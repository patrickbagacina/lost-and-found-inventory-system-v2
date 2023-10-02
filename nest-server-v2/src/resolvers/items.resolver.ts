import { UseGuards } from '@nestjs/common';
import { Args, Int, Mutation, Query, Resolver } from '@nestjs/graphql';
import { RegisterItemInput, UpdateItemInput } from 'src/dto/item.input';
import { AuthGuard } from 'src/guards/auth.guard';
import { LostItem } from 'src/models/item.model';
import { ItemsService } from 'src/services/items.service';

@Resolver(() => LostItem)
export class ItemsResolver {
  constructor(private readonly itemsService: ItemsService) {}

  @UseGuards(AuthGuard)
  @Mutation(() => LostItem)
  registerItem(
    @Args('registerItemInput') registerItemInput: RegisterItemInput,
  ) {
    return this.itemsService.registerItem(registerItemInput);
  }

  @UseGuards(AuthGuard)
  @Mutation(() => LostItem)
  updateItem(@Args('updateItemInput') updateItemInput: UpdateItemInput) {
    return this.itemsService.updateItem(updateItemInput);
  }

  @UseGuards(AuthGuard)
  @Query(() => [LostItem])
  findAll() {
    return this.itemsService.findAll();
  }

  @UseGuards(AuthGuard)
  @Query(() => LostItem)
  findOne(@Args('item_id', { type: () => Int }) id: number) {
    return this.itemsService.findOne(id);
  }
}
