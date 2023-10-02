import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { GraphQLModule } from '@nestjs/graphql';
import { ApolloDriver } from '@nestjs/apollo';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from './modules/users.module';
import { ItemsModule } from './modules/items.module';
import * as dotenv from 'dotenv';
dotenv.config();

@Module({
  imports: [
    GraphQLModule.forRoot({
      driver: ApolloDriver,
      autoSchemaFile: './schema.gql',
      debug: true,
      playground: true,
      context: ({ req }) => {
        return { token: req.headers.authorization };
      },
    }),
    TypeOrmModule.forRoot({
      keepConnectionAlive: true,
      type: 'postgres',
      port: parseInt(<string>process.env.POSTGRES_PORT),
      username: process.env.POSTGRES_USER,
      password: process.env.POSTGRES_PASSWORD,
      database: process.env.POSTGRES_DB,
      autoLoadEntities: true,
      synchronize: true,
      schema: process.env.POSTGRES_DB,
      host:
        process.env.NODE_ENV == 'production'
          ? process.env.POSTGRES_DOCKER_HOST
          : process.env.POSTGRES_HOST,
    }),
    UsersModule,
    ItemsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
