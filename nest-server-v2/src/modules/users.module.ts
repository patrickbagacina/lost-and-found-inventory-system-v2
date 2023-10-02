import { Module } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from 'src/models/user.model';
import { UsersResolver } from 'src/resolvers/users.resolver';
import { UsersService } from 'src/services/users.service';
import { ItemsModule } from './items.module';

@Module({
  imports: [TypeOrmModule.forFeature([User]), ItemsModule],
  providers: [UsersResolver, UsersService, JwtService],
})
export class UsersModule {}
