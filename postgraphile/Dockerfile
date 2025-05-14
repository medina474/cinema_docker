FROM node:alpine
LABEL description="Instant high-performance GraphQL API for your PostgreSQL database https://github.com/graphile/postgraphile"

# Install PostGraphile and PostGraphile connection filter plugin
RUN npm install -g postgraphile &&\
  npm install -g postgraphile-plugin-connection-filter &&\
  npm install -g @graphile/postgis  &&\
  npm install -g postgraphile-plugin-connection-filter-postgis &&\
  npm install -g postgraphile-plugin-fulltext-filter

EXPOSE 3001
ENTRYPOINT ["postgraphile", "--host", "0.0.0.0", "--port", "3001", "--schema", "public", "--enhance-graphiql", "--cors", "--allow-explain", "--dynamic-json", "--append-plugins", "postgraphile-plugin-connection-filter,postgraphile-plugin-fulltext-filter,@graphile/postgis,postgraphile-plugin-connection-filter-postgis"]
