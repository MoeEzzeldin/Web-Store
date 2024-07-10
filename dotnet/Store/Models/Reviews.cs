using System;
using System.ComponentModel.DataAnnotations;

namespace webstore.Models
{
    public class Review
    {
        public int ReviewId { get; set; }
        public int ProductId { get; set; }
        public string Title { get; set; }
        public string comment { get; set; }
        [Range(1, 5)]
        public int Rating { get; set; }
        public string Reviewer { get; set; }
        public DateTime Date { get; set; }
    }

    public class UserReview
    {
        public int UserId { get; set; }
        public int ReviewId { get; set; }
    }
   
}
