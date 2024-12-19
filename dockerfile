# Step 1: Use the official Node.js image
FROM node:18-alpine AS build

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Step 4: Copy all files
COPY . .

# Step 5: Build the Next.js app
RUN npm run build

# Step 6: Serve the app using next start
FROM node:18-alpine

WORKDIR /app

COPY --from=build /app /app

RUN npm install --only=production

EXPOSE 3000

CMD ["npm", "start"]
