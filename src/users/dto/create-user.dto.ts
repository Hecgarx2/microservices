import { IsString, IsEmail, IsNotEmpty, IsArray } from "class-validator";

export class CreateUserDto {
    @IsEmail()
    @IsNotEmpty()
    public email: string;
    @IsString()
    @IsNotEmpty()
    public name: string;
    @IsString()
    @IsNotEmpty()
    public password: string;
    @IsArray()
    @IsNotEmpty()
    public roles: string[];
}
