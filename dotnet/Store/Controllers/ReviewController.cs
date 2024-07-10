using webstore.DAO.Interface;
using webstore.Exceptions;
using webstore.Models;
using webstore.Security;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace webstore.Controllers
{
    [Route("[controller]")]
    [ApiController]

    public class ReviewController : ControllerBase
    {
        private readonly IReviewDao reviewDao;
        private readonly IUserDao userDao;
        public ReviewController(
            IReviewDao reviewDao,
            IUserDao userDao
            )
        {
            this.reviewDao = reviewDao;
            this.userDao = userDao;
        }

        /// <summary>
        /// review
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult<List<Review>> GetReview()
        {
            List<Review> reviews = new List<Review>();

            reviews = reviewDao.GetReviews();

            if (reviews.Count == 0)
            {
                return NotFound();
            }
            else
            {
                return Ok(reviews);
            }
        }
        /// <summary>
        /// review/3
        /// </summary>
        /// <param name="ProductId"></param>
        /// <returns></returns>
        [HttpGet("{id}")]
        public ActionResult<Review> GetReviewsByProductId(int productId)
        {
            List<Review> result = new List<Review>();


            result = reviewDao.GetReviewsByProductId(productId);
            if (result == null)
            {
                return BadRequest();
            }
            else
            {
                return Ok(result);
            }
        }


        /// <summary>
        /// {productId}/averageRating
        /// </summary>
        /// <param name="productId"></param>
        /// <returns></returns>
        /// 
        [HttpGet("{productId}/averageRating")]
        public ActionResult GetAverageRating(int productId)
        {
            decimal result = reviewDao.GetAverageRating(productId);
            if (result == 0)
            {
                return BadRequest();
            }
            else
            {
                return Ok(result);
            }
        }


        /// <summary>
        /// here we are adding a review, but we are also setting the reviewer name to the current user
        /// then we're adding the review to the database
        /// </summary>
        /// <param name="review"></param>
        /// <returns>Created</returns>
        [HttpPost]
        public ActionResult<Review> AddReview(Review review)
        {
            int result; // this is the review id
            User loggedInUser = null; // get current user to use userId to add review in user/review Entity
            if (review == null || User.Identity.Name == null)
            {
                return BadRequest();
            }
            else
            {
                result = reviewDao.AddAReview(review);// add review and return me reviewId or -1 if failed
                if (result == -1)
                {
                    return BadRequest();
                }
                else
                {
                    loggedInUser = userDao.GetUserByUsername(User.Identity.Name);
                    if (loggedInUser == null)
                    {
                        return BadRequest();
                    }
                    else
                    {//add review to user_review table
                        bool check = reviewDao.AddUserReview(loggedInUser.UserId, result);
                        if (check)
                        {
                            return Created("/product", result);
                        }
                        return BadRequest();
                    }

                }
            }

        }

    }
}
