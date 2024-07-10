using System.Collections.Generic;
using webstore.Models;

namespace webstore.DAO.Interface
{
    public interface IReviewDao
    {
        List<Review> GetReviews();
        //List<Review> GetProductByName(string ProductName);
        Review GetReviewById(int id);
        int AddAReview(Review review);
        bool AddUserReview(int userId, int reviewId);
        decimal GetAverageRating(int productId);
        List<Review> GetReviewsByProductId(int productId);
    }
}
