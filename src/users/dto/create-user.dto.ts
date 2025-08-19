import { IsString, IsEmail, IsNotEmpty } from "class-validator";

export class CreateUserDto {
    @IsEmail()
    @IsNotEmpty()
    public email: string;
    @IsString()
    @IsNotEmpty()
    public password: string;
    @IsString()
    @IsNotEmpty()
    public name: string;
    @IsString()
    @IsNotEmpty()
    public role: string;
}
