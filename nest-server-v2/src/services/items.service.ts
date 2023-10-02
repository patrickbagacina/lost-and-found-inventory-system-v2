import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { RegisterItemInput, UpdateItemInput } from 'src/dto/item.input';
import { LostItem } from 'src/models/item.model';
import { Repository } from 'typeorm';

@Injectable()
export class ItemsService {
  constructor(
    @InjectRepository(LostItem)
    private readonly itemRepository: Repository<LostItem>,
  ) {}

  async registerItem(input: RegisterItemInput): Promise<LostItem> {
    const item = this.itemRepository.create(input);
    return await this.itemRepository.save(item);
  }

  async updateItem(updateItemInput: UpdateItemInput): Promise<LostItem> {
    const item = await this.itemRepository.preload({
      item_id: updateItemInput.item_id,
      ...updateItemInput,
    });
    if (!item) {
      throw new NotFoundException(`Item #${updateItemInput.item_id} not found`);
    }
    return this.itemRepository.save(item);
  }

  async findAll(): Promise<Array<LostItem>> {
    return await this.itemRepository.find();
  }

  async findOne(id: number): Promise<LostItem> {
    const item = await this.itemRepository.findOne({
      where: {
        item_id: id,
      },
    });
    if (!item) {
      throw new NotFoundException(`User #${id} not found`);
    }
    return item;
  }
}
