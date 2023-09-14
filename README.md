# Syft Hackathon

## Overview
This is the demo repository for the final round of the Syft Hackathon. The repository has been set up with both a frontend and backend service. The backend is a basic node express server, with Typescript enabled. The fontend is a create-react-app, also with Typescript enabled. The repository is setup as a monorepo using pnpm as the workspace management tool and package manager (Note if you decide to use this repo you would need to continue using pnpm, node, yarn or any other package managerment tool is likely to cause issues). a Dockerfile has been provided, which builds both services as seperate images.

## Commands
### Server
1. **pnpm --filter server dev** - starts the backend server in development mode.
2. **pnpm --filter server build** - builds the server entity to the lib directory.
3. **pnpm --filter server prod** - starts the backend server in production mode ( Note: the prod commands servers from lib, hence it needs to build first ).

### Web
1. **pnpm --filter web dev** - starts web in development mode.
2. **pnpm --filter web build** - builds web to the build directory.
3. **pnpm --filter web prod** - starts web in production mode ( Note: the prod commands servers from lib, hence it needs to build first ).

### Docker
1. **docker build --target web -t ${TAG} ${CONTEXT} --push** - builds and pushes the 

