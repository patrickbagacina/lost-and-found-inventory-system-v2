import { InputType, Field } from '@nestjs/graphql';

@InputType()
export class LoginUserInput {
  @Field(() => String, { description: 'Account username', nullable: false })
  username: string;
  @Field(() => String, { description: 'Account password', nullable: false })
  password: string;
}

@InputType()
export class RegisterUserInput {
  @Field(() => String, { description: 'Account username', nullable: false })
  username: string;
  @Field(() => String, { description: 'Account password', nullable: false })
  password: string;
  @Field(() => String, { description: 'Name of user', nullable: false })
  name: string;
}
