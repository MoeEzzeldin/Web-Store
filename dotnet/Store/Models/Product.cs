namespace webstore.Models
{
    public class Product
    {
        public int ProductId { get; set; }
        public string Brand { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public decimal Price { get; set; }
        public string PictureUrl { get; set; }
    }
    public class UpdateProduct
    {
        public string Brand { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public decimal Price { get; set; }
        public string PictureUrl { get; set; }
    }
}
