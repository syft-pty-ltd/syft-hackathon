FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
RUN npm install -g serve
COPY . /app
WORKDIR /app

#First install dependencies
FROM base AS prod-deps
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

#build each underlying application
FROM base AS build
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run -r build

#web script
FROM base AS web
COPY --from=prod-deps /app/apps/web/node_modules/ /app/apps/web/node_modules
COPY --from=build /app/apps/web/public /app/apps/web/public
WORKDIR /app/apps/web
RUN ls
EXPOSE 3000
CMD [ "pnpm", "prod" ]

#server script
FROM base AS server
COPY --from=prod-deps /app/apps/server/node_modules/ /app/apps/server/node_modules
COPY --from=build /app/apps/server/lib /app/apps/server/lib
WORKDIR /app/apps/server
EXPOSE 8000
CMD [ "pnpm", "prod" ]