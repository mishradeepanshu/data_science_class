use questions_exam;

/*write a query where it should all the data of the movies which were released after 1995
 having their duration greater than 120min 
 and should be included Amin movie title
 */
SELECT 
    *
FROM
    movie
WHERE
    mov_year > 1995 AND mov_time > 120
        AND mov_title LIKE 'A%';
 
/*
write an sql query to find the actors who played a role in the movie 'chinatown'. Fetch all the fields of actor table
(hint use the IN operator)
*/
SELECT 
    act_id, act_fname, act_lname, act_gender
FROM
    actor
WHERE
    act_id IN (SELECT 
            cast.act_id
        FROM
            cast
                JOIN
            movie ON movie.mov_id = cast.mov_id
        WHERE
            movie.mov_title = 'Chinatown');
            
# using in keyword querey
SELECT 
    *
FROM
    actor
WHERE
    act_id IN (SELECT 
            act_id
        FROM
            cast
        WHERE
            mov_id IN (SELECT 
                    mov_id
                FROM
                    movie
                WHERE
                    mov_title = 'Chinatown'));
 
 /*
 write an SQL query for extracting the data from ratings table for the movie 
 who got maximum number of ratings.*/
 
 select * FROM movie;
 
 select mov_title from movie where mov_id in (select mov_id,max(num_o_ratings) as rt from ratings order by rt desc limit 1);
 

 
SELECT 
    *
FROM
    ratings
ORDER BY num_o_ratings DESC
LIMIT 1;


/*write an sql query to determine the top 7 movies which ere realeased in united kingdom
 sort the data in ascending order of the movie year */
 
SELECT 
    *
FROM
    movie
WHERE
    mov_rel_country = 'UK'
ORDER BY mov_dt_rel asc
LIMIT 7;

/* set the language of movie language as 'Chinese' for the moview which has its existing
 language as japanese and their movie year was 2001
*/
UPDATE movie 
SET 
    mov_lang = 'Chinese'
WHERE
    mov_lang = 'Japanese'
        AND mov_year = 2001;


/* print genre title maximum movie duration and the count the number of movies in each genre*/
select gen_id, max(mov_time), count(gen_id)
From genres inner join movie_genres ON genres.gen_id = movie_genres.gen_id inner join movie on movie_genres.mov_id = movie.mov_id;

SELECT 
    g.gen_title,
    MAX(mov_time) AS duration,
    COUNT(*) AS mov_count
FROM
    movie AS m
        INNER JOIN
    movie_genres AS mg ON m.mov_id = mg.mov_id
        INNER JOIN
    genres AS g ON mg.gen_id = g.gen_id
GROUP BY gen_title;


/* create a view which should contain the first name, last nae, title of the movie and role play by particular actor. */
CREATE VIEW ActorMovieRolee AS
    SELECT 
        a.act_fname, a.act_lname, m.mov_title, c.role
    FROM
        movie AS m
            INNER JOIN
        cast AS c ON m.mov_id = c.mov_id
            INNER JOIN
        actor AS a ON c.act_id = a.act_id;

        








