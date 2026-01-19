# VK Mobile App

A TypeScript-based Node.js application with Express, Prisma, and Winston logging.

## Features

- ✅ TypeScript
- ✅ Express.js
- ✅ Prisma ORM
- ✅ Winston Logger
- ✅ Environment Variables (dotenv)
- ✅ Nodemon for development
- ✅ Swagger UI for API documentation
- ✅ Graceful shutdown handling

## Prerequisites

- Node.js (v18 or higher)
- PostgreSQL database
- npm or yarn

## Getting Started

### 1. Install Dependencies

```bash
npm install
```

### 2. Set Up Environment Variables

Copy the example environment file and update it with your values:

```bash
copy .env.example .env
```

Edit `.env` and update the `DATABASE_URL` with your PostgreSQL connection string.

### 3. Set Up Prisma

Generate Prisma client:

```bash
npm run prisma:generate
```

Run database migrations:

```bash
npm run prisma:migrate
```

(Optional) Open Prisma Studio to view/edit your database:

```bash
npm run prisma:studio
```

### 4. Run the Application

**Development mode** (with hot reload):

```bash
npm run dev
```

**Production mode**:

```bash
npm run build
npm start
```

## Available Scripts

- `npm run dev` - Start development server with nodemon
- `npm run build` - Compile TypeScript to JavaScript
- `npm start` - Run compiled JavaScript
- `npm run prisma:generate` - Generate Prisma Client
- `npm run prisma:migrate` - Run database migrations
- `npm run prisma:studio` - Open Prisma Studio

## API Endpoints

- `GET /api-docs` - Swagger UI API documentation (interactive)
- `GET /health` - Health check endpoint
- `GET /api/users` - Get all users (example)

Visit `http://localhost:3000/api-docs` after starting the server to explore the interactive API documentation.

## Project Structure

```
vkmobileapp/
├── prisma/
│   └── schema.prisma       # Prisma schema
├── src/
│   ├── config/
│   │   ├── logger.ts       # Winston logger configuration
│   │   └── database.ts     # Prisma client instance
│   └── index.ts            # Main application file
├── logs/                   # Application logs (auto-generated)
├── .env                    # Environment variables (create from .env.example)
├── .env.example            # Example environment variables
├── .gitignore              # Git ignore rules
├── nodemon.json            # Nodemon configuration
├── package.json            # Dependencies and scripts
├── tsconfig.json           # TypeScript configuration
└── README.md               # This file
```

## Logging

The application uses Winston for logging. Logs are written to:
- `logs/combined.log` - All logs
- `logs/error.log` - Error logs only
- Console output (in development mode)

Log level can be configured via the `LOG_LEVEL` environment variable.

## Database

This application uses PostgreSQL with Prisma ORM. Modify `prisma/schema.prisma` to define your data models, then run migrations to update the database schema.

## License

ISC
