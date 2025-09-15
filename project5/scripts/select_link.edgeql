select Movie {
    title,
    year,
    director: {
        first_name,
        last_name
    },
    actors: {
        first_name,
        last_name
    }
};
