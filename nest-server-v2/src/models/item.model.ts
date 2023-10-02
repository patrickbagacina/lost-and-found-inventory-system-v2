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
export class LostItem {
  @PrimaryGeneratedColumn('increment')
  @Field(() => Int, { description: 'ID of the lost item' })
  item_id: number;

  @Column()
  @Field(() => String, { description: 'Category of the item' })
  category: string;

  @Column()
  @Field(() => String, { description: 'Type of item' })
  item_type: string;

  @Column()
  @Field(() => String, { description: 'Item brand' })
  brand: string;

  @Column()
  @Field(() => String, { description: 'Item description' })
  description: string;

  @Column('boolean', { default: false })
  @Field(() => Boolean, { description: 'Item status', defaultValue: false })
  is_claimed: boolean;

  @CreateDateColumn()
  @Field(() => String, { description: 'Date created' })
  created_at: Date;

  @UpdateDateColumn()
  @Field(() => String, { description: 'Date last updated' })
  updated_at: Date;
}
