import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';
import { LoginUserInput, RegisterUserInput } from 'src/dto/user.input';
import { User } from 'src/models/user.model';
import { UsersService } from 'src/services/users.service';

@Resolver(() => User)
export class UsersResolver {
  constructor(private readonly usersService: UsersService) {}

  @Mutation(() => User)
  login(@Args('loginUserInput') loginUserInput: LoginUserInput) {
    return this.usersService.login(loginUserInput);
  }

  @Mutation(() => User)
  registerUser(
    @Args('registerUserInput') registerUserInput: RegisterUserInput,
  ) {
    return this.usersService.registerUser(registerUserInput);
  }

  @Query(() => User)
  getUser(): string {
    return 'Hi User!';
  }
}
