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

    public class ProductController : ControllerBase
    {
        private readonly IProductDao productDao;

        public ProductController(
            IProductDao productDao
            )
        {
            this.productDao = productDao;
        }


        /// <summary>
        /// Retrieves a list of products based on provided filters.
        /// Possible routes:
        /// /product
        /// /product?productName={productName}
        /// </summary>
        /// <param name="productName">Product name filter</param>
        /// <returns>List of products matching the filters</returns>
        [HttpGet]
        public ActionResult<List<Product>> GetProductsParamName([FromQuery] string productName = "")
        {
            List<Product> products = new List<Product>();

            // Check if productName is provided
            if (!string.IsNullOrEmpty(productName))
            {
                products = productDao.GetProductByName(productName);
                if (products == null || products.Count == 0)
                {
                    return NotFound();
                }
                return Ok(products);
            }

            // If productName isn't provided, return all products
            else
            {
                products = productDao.GetProducts();
                if (products == null || products.Count == 0)
                {
                    return NotFound();
                }
                return Ok(products);
            }
        }

        /// <summary>
        /// the method calls the dao method to filter products by price
        /// </summary>
        /// <param name="min"></param>
        /// <param name="max"></param>
        /// <returns></returns>

        [HttpGet("price")]
        public ActionResult<List<Product>> GetProductsParamPrice([FromQuery] int? min = null, [FromQuery] int? max = null)
        {
            List<Product> products = new List<Product>();

            // Check if min or max is provided
            if (min.HasValue || max.HasValue)
            {
                products = productDao.FilterProductsByPrice(min.GetValueOrDefault(0), max.GetValueOrDefault(int.MaxValue));
                if (products == null || products.Count == 0)
                {
                    return NotFound();
                }
                return Ok(products);
            }
            else
            {
                return BadRequest();
            }
        }

        /// <summary
        /// product/3
        /// </summary>
        /// <param name="id"></param>
        /// <returns>200</returns>
        [HttpGet("{id}")]
        public ActionResult<Product> GetProduct(int id)
        {
            Product result = productDao.GetProductById(id);
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
        /// /product
        /// </summary>
        /// <param name="product"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult<Product> AddProduct(Product product)
        {
            Product result = productDao.AddProduct(product);

            if (result.ProductId == 0)
            {
                return BadRequest();
            }
            else
            {
                return Created("/admin", result);
            }

        }

        /// <summary>
        /// This method updates a product.
        /// </summary>
        /// <param name="product"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPut("{id}")]
        public ActionResult<UpdateProduct> UpdateProduct(UpdateProduct product, int id)
        {
            UpdateProduct result = productDao.UpdateProduct(product, id);

            if (result == null)
            {
                return BadRequest();
            }
            else
            {
                return Created("/Home", result);
            }
        }

        /// <summary>
        /// /product/3  deletes a product using the product_Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete("{id}")]
        public AcceptedResult DeleteProduct(int id)
        {
            bool result = productDao.DeleteProduct(id);

            if (result == false)
            {
                return Accepted();
            }
            else
            {
                return Accepted();
            }
        }

    }
}
