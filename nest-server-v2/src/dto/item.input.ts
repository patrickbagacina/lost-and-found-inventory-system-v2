import { InputType, Field, Int } from '@nestjs/graphql';

@InputType()
export class RegisterItemInput {
  @Field(() => String, { description: 'Item category', nullable: false })
  category: string;
  @Field(() => String, { description: 'Item type', nullable: false })
  item_type: string;
  @Field(() => String, { description: 'Item brand', nullable: false })
  brand: string;
  @Field(() => String, { description: 'Item description', nullable: false })
  description: string;
}

@InputType()
export class UpdateItemInput {
  @Field(() => Int, { description: 'Item category', nullable: false })
  item_id: number;
  @Field(() => String, { description: 'Item category', nullable: false })
  category: string;
  @Field(() => String, { description: 'Item type', nullable: false })
  item_type: string;
  @Field(() => String, { description: 'Item brand', nullable: false })
  brand: string;
  @Field(() => String, { description: 'Item description', nullable: false })
  description: string;
  @Field(() => Boolean, { description: 'Item status', nullable: false })
  is_claimed: boolean;
}
