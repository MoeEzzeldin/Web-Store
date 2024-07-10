using System.Collections.Generic;
using webstore.Models;

namespace webstore.DAO.Interface
{
    public interface IProductDao
    {
        List <Product> GetProductByName(string productName);
        List<Product> GetProducts();
        //List<Product> GetProductByName(string ProductName);
        Product GetProductById(int id);
        Product AddProduct(Product product);
        UpdateProduct UpdateProduct(UpdateProduct product, int id);
        bool DeleteProduct(int id);
        List<Product> FilterProductsByPrice(int minPrice, int maxPrice);
    }
}
