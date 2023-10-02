import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(private jwtService: JwtService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const arg = context.getArgs().find((a) => a?.token != null);
    if (!arg) {
      throw new UnauthorizedException();
    }

    const token = this.extractTokenFromHeader(arg);
    if (!token) {
      throw new UnauthorizedException();
    }
    try {
      await this.jwtService.verifyAsync(token, {
        secret: process.env.JWT_SECRET,
      });
    } catch {
      throw new UnauthorizedException();
    }
    return true;
  }

  private extractTokenFromHeader(arg: any): string | undefined {
    const [type, token] = arg.token.split(' ') ?? [];
    return type === 'Bearer' ? token : undefined;
  }
}
