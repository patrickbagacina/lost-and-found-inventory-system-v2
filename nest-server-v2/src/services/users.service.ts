import { Injectable, UnauthorizedException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { LoginUserInput, RegisterUserInput } from 'src/dto/user.input';
import { User } from 'src/models/user.model';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import { ValidationException } from 'src/exceptions/validation';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    private jwtService: JwtService,
  ) {}

  async login(input: LoginUserInput) {
    const user = await this.userRepository.findOne({
      where: {
        username: input.username,
      },
    });
    if (!user || user?.password !== input.password) {
      throw new UnauthorizedException();
    }
    const payload = { sub: user.user_id, username: user.username };
    user.access_token = await this.jwtService.signAsync(payload, {
      secret: process.env.JWT_SECRET,
    });

    return user;
  }

  async registerUser(input: RegisterUserInput): Promise<User> {
    const u = await this.userRepository.findOne({
      where: {
        username: input.username,
      },
    });

    if (u) {
      throw new ValidationException('Username is already used!');
    }

    const user = this.userRepository.create(input);
    return await this.userRepository.save(user);
  }
}
