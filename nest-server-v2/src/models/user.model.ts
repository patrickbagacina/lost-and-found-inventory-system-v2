import { ObjectType, Field, Int } from '@nestjs/graphql';
import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity()
@ObjectType()
export class User {
  @PrimaryGeneratedColumn('increment')
  @Field(() => Int, { description: 'ID of the user' })
  user_id: number;

  @Column()
  @Field(() => String, { description: 'Name of the user' })
  name: string;

  @Column()
  @Field(() => String, { description: 'Account username' })
  username: string;

  @Column()
  @Field(() => String, { description: 'Account password' })
  password: string;

  @CreateDateColumn()
  @Field(() => String, { description: 'Date created' })
  created_at: Date;

  @UpdateDateColumn()
  @Field(() => String, { description: 'Date last updated' })
  updated_at: Date;

  @Field()
  access_token?: string;
}
