using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using webstore.DAO.Interface;
using webstore.Exceptions;
using webstore.Models;
using Microsoft.AspNetCore.Mvc;
namespace webstore.DAO
{
    public class ReviewSqlDao : IReviewDao
    {
        private readonly string connectionString;

        public ReviewSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }


        public List<Review> GetReviews()
        {
            List<Review> reviews = new List<Review>();
            string sql = @"SELECT review_id, product_id, title, comment, rating, reviewer, date FROM review;";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Review review = MapRowToReview(reader);
                        reviews.Add(review);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return reviews;
        }
        //this method makes Sql calc avg rating based  on a product_id,
        //and it's used everytime a user wants to see a product
        public decimal GetAverageRating(int productId)
        {
            decimal averageRating = 0;
            string sql = @"SELECT AVG(rating) FROM review WHERE @product_id = product_id;";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@product_id", productId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        if (reader[0] != DBNull.Value)
                        {
                            return averageRating = Convert.ToDecimal(reader[0]);  
                        }
                        return averageRating;
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return averageRating;
        }
        //this method is called when a user wants to update a review? get review by id @click to edit review
        public Review GetReviewById(int id)
        {
            Review review = null;
            string sql = @"SELECT review_id, product_id, title, comment, rating, reviewer, date FROM review WHERE @id = review_id;";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", id);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        review = MapRowToReview(reader);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return review;
        }
        //this method is called when the user route to product-view page,
        //and it returns all the reviews for the selected product
        public List<Review> GetReviewsByProductId(int productId)
        {
            List<Review> reviews = new();
            string sql = @"SELECT review_id, product_id, title, comment, rating, reviewer, date FROM review WHERE @id = product_id;";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", productId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Review review = new();
                        review = MapRowToReview(reader);
                        reviews.Add(review);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return reviews;
        }

        // this method adds review to review table and returns the review_id
        public int AddAReview(Review review)
        {
            int newReview = -1;    // sat to -1 to indicate that the review was not added
            string sql = @"INSERT INTO review (product_id, title, comment, date, rating, reviewer)
                            OUTPUT INSERTED.review_id
                            VALUES(@product_id, @title, @comment, @date, @rating, @reviewer);";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@product_id", review.ProductId);
                        cmd.Parameters.AddWithValue("@reviewer", review.Reviewer);
                        cmd.Parameters.AddWithValue("@date", review.Date);
                        cmd.Parameters.AddWithValue("@title", review.Title);
                        cmd.Parameters.AddWithValue("@comment", review.comment);
                        cmd.Parameters.AddWithValue("@rating", review.Rating);
                        newReview = (int)cmd.ExecuteScalar();
                    }
                }
            }

            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return newReview; // returns Int review_id or -1;
        }

        //this method is called only if AddAReview is successful,
        //and it adds the review_id and user_id to the user_review table
        public bool AddUserReview(int userId, int reviewId)
        {
            bool result = false;
            string sql = @"INSERT INTO user_review (user_id, review_id)
                            VALUES(@user_id, @review_id);";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@user_id", userId);
                        cmd.Parameters.AddWithValue("@review_id", reviewId);
                        if (cmd.ExecuteNonQuery() > 0)
                        {
                            result = true;
                        }
                        else
                        {
                            return result;
                        }
                    }
                }
            }

            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return result;
        }

        //this method map
        private Review MapRowToReview(SqlDataReader reader)
        {
            Review review = new Review();
            review.ReviewId = Convert.ToInt32(reader["review_id"]);
            review.ProductId = Convert.ToInt32(reader["product_id"]);
            review.Title = Convert.ToString(reader["title"]);
            review.Title = Convert.ToString(reader["comment"]);
            review.Rating = Convert.ToInt32(reader["rating"]);
            review.Reviewer = Convert.ToString(reader["reviewer"]);
            review.Date = Convert.ToDateTime(reader["date"]);
            return review;
        }
    }
}
