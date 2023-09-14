FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
RUN npm install -g serve
RUN npm install -g typescript
COPY . /app
WORKDIR /app

#build each underlying application
FROM base AS build
RUN pnpm install --prod --frozen-lockfile
RUN pnpm run -r build

#web script
FROM build AS web
WORKDIR /app/apps/web
EXPOSE 3000
CMD [ "pnpm", "prod" ]

#server script
FROM build AS server
WORKDIR /app/apps/server
EXPOSE 8000
CMD [ "pnpm", "prod" ]