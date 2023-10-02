import { BadRequestException } from '@nestjs/common/exceptions';

export class ValidationException extends BadRequestException {
  constructor(msg: string) {
    super(msg);
  }
}
