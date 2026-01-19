import swaggerJsdoc from 'swagger-jsdoc';
import { version } from '../../package.json';

const options: swaggerJsdoc.Options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'VK Mobile App API',
      version: version,
      description: 'API documentation for VK Mobile App',
      contact: {
        name: 'API Support',
        email: 'support@vkmobileapp.com',
      },
      license: {
        name: 'ISC',
        url: 'https://opensource.org/licenses/ISC',
      },
    },
    servers: [
      {
        url: 'http://localhost:3000',
        description: 'Development server',
      },
      {
        url: 'https://api.vkmobileapp.com',
        description: 'Production server',
      },
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        },
      },
      schemas: {
        User: {
          type: 'object',
          required: ['user_name', 'user_password'],
          properties: {
            user_id: {
              type: 'string',
              format: 'uuid',
              description: 'Unique user identifier',
              example: '550e8400-e29b-41d4-a716-446655440000',
            },
            user_name: {
              type: 'string',
              description: 'User name',
              example: 'john_doe',
            },
            user_password: {
              type: 'string',
              description: 'User password (hashed)',
              example: 'hashed_password_here',
            },
            is_active: {
              type: 'boolean',
              description: 'Whether the user is active',
              default: true,
            },
            is_deleted: {
              type: 'boolean',
              description: 'Whether the user is deleted',
              default: false,
            },
            is_appvd: {
              type: 'boolean',
              description: 'Whether the user is approved',
              default: false,
            },
            sync_date: {
              type: 'string',
              format: 'date-time',
              description: 'Last sync timestamp',
              nullable: true,
            },
            created_date: {
              type: 'string',
              format: 'date-time',
              description: 'User creation timestamp',
            },
            modified_date: {
              type: 'string',
              format: 'date-time',
              description: 'User last modification timestamp',
            },
            device_type: {
              type: 'string',
              description: 'Device type',
              example: 'mobile',
              nullable: true,
            },
            device_id: {
              type: 'string',
              description: 'Device identifier',
              example: 'ABC123XYZ',
              nullable: true,
            },
          },
        },
        HealthCheck: {
          type: 'object',
          properties: {
            status: {
              type: 'string',
              enum: ['OK', 'ERROR'],
              description: 'Health status',
            },
            timestamp: {
              type: 'string',
              format: 'date-time',
              description: 'Timestamp of health check',
            },
            database: {
              type: 'string',
              enum: ['connected', 'disconnected'],
              description: 'Database connection status',
            },
          },
        },
        Error: {
          type: 'object',
          properties: {
            error: {
              type: 'string',
              description: 'Error message',
            },
          },
        },
      },
    },
    security: [
      {
        bearerAuth: [],
      },
    ],
  },
  apis: ['./src/**/*.ts'], // Path to the API routes
};

const swaggerSpec = swaggerJsdoc(options);

export default swaggerSpec;
