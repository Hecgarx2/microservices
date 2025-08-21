import 'dotenv/config';
import * as joi from 'joi';

interface EnvVars {
    PORT: number;
    DATABASE_URL: string;
    // Add other env variables here
}

const envVarsSchema = joi.object<EnvVars>({
    PORT: joi.number().required(),
    DATABASE_URL: joi.string().required(),
    // Add other env variables validation here
}).unknown(true);

export const validateEnvVars = (envVars: Record<string, unknown>) => {
    const { error, value } = envVarsSchema.validate(envVars);
    if (error) {
        throw new Error(`Config validation error: ${error.message}`);
    }
    return value;
};
