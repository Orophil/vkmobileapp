import { Request, Response } from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import prisma from '../config/database';
import logger from '../config/logger';

const JWT_SECRET = process.env.JWT_SECRET || 'your_super_secret_key';

export const register = async (req: Request, res: Response): Promise<void> => {
  try {
    const { user_name, user_password, device_type, device_id } = req.body;

    // Check if user already exists
    const existingUser = await prisma.user.findFirst({
      where: { user_name },
    });

    if (existingUser) {
      res.status(400).json({ error: 'Username already taken' });
      return;
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(user_password, 10);

    // Create user
    const user = await prisma.user.create({
      data: {
        user_name,
        user_password: hashedPassword,
        device_type,
        device_id,
        is_active: true,
        is_appvd: false, // Default to false for manual approval
      },
    });

    // Generate JWT
    const token = jwt.sign({ userId: user.user_id }, JWT_SECRET, { expiresIn: '24h' });

    res.status(201).json({
      message: 'User registered successfully',
      token,
      user: {
        user_id: user.user_id,
        user_name: user.user_name,
      },
    });
  } catch (error) {
    logger.error('Registration error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

export const login = async (req: Request, res: Response): Promise<void> => {
  try {
    const { user_name, user_password } = req.body;

    // Find user
    const user = await prisma.user.findFirst({
      where: { user_name, is_deleted: false },
    });

    if (!user) {
      res.status(401).json({ error: 'Invalid credentials' });
      return;
    }

    if (!user.is_active) {
      res.status(403).json({ error: 'Account is inactive' });
      return;
    }

    // Verify password
    const isPasswordValid = await bcrypt.compare(user_password, user.user_password);
    if (!isPasswordValid) {
      res.status(401).json({ error: 'Invalid credentials' });
      return;
    }

    // Generate JWT
    const token = jwt.sign({ userId: user.user_id }, JWT_SECRET, { expiresIn: '24h' });

    res.json({
      message: 'Login successful',
      token,
      user: {
        user_id: user.user_id,
        user_name: user.user_name,
        is_appvd: user.is_appvd,
      },
    });
  } catch (error) {
    logger.error('Login error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};
