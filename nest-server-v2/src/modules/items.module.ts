import { Module } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthGuard } from 'src/guards/auth.guard';
import { LostItem } from 'src/models/item.model';
import { ItemsResolver } from 'src/resolvers/items.resolver';
import { ItemsService } from 'src/services/items.service';

@Module({
  imports: [TypeOrmModule.forFeature([LostItem]), ItemsModule],
  providers: [ItemsResolver, ItemsService, AuthGuard, JwtService],
})
export class ItemsModule {}
