using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using webstore.DAO.Interface;
using webstore.Exceptions;
using webstore.Models;
using webstore.Security;
using webstore.Security.Models;
using Microsoft.AspNetCore.Mvc;

namespace webstore.DAO
{
    public class ProductSqlDao : IProductDao
    {
        private readonly string connectionString;

        public ProductSqlDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns>Lists<Product> </returns>
        /// <exception cref="DaoException"></exception>
        public List<Product> GetProducts()
        {
            List<Product> product = new List<Product>();
            string sql = @"SELECT product_id, brand, name, type, price, picture_url FROM product;";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Product products = MapRowToProduct(reader);
                        product.Add(products);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return product;
        }

        /// <summary>
        /// returns a list of products based on price range
        /// Vue.js specify the min and max price
        /// </summary>
        /// <param name="minPrice"></param>
        /// <param name="maxPrice"></param>
        /// <returns></returns>
        /// <exception cref="DaoException"></exception>
        public List<Product> FilterProductsByPrice(int minPrice, int maxPrice)
        {
            List<Product> products = new List<Product>();
            string sql = @"SELECT product_id, brand, name, type, price, picture_url FROM product WHERE price >= @minPrice AND price <= @maxPrice;";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@minPrice", minPrice);
                    cmd.Parameters.AddWithValue("@maxPrice", maxPrice);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Product product = MapRowToProduct(reader);
                        products.Add(product);
                    }
                }
            }
            catch (SqlException ex)
            {
                // Handle SQL exception, possibly log it or throw a custom exception
                throw new DaoException("SQL exception occurred", ex);
            }

            return products;
        }

        /// <summary>
        /// GetProductById() returns a product by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>product</returns>
        /// <exception cref="DaoException"></exception>

        public Product GetProductById(int id)
        {
            Product product = null;
            string sql = @"SELECT product_id, brand, name, type, price, picture_url FROM product WHERE @id = product_id;";
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
                        product = MapRowToProduct(reader);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return product;
        }

        /// <summary>
        /// get product by name
        /// </summary>
        /// <param name="productName"></param>
        /// <returns>product</returns>
        /// <exception cref="DaoException"></exception>
        public List<Product> GetProductByName(string productName)
        {
            List<Product> product = new List<Product>();
            Product temp = new Product();
            string sql = @"select product_id, brand, name, type, price, picture_url from product where name like @name;";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@name", "%" + productName + "%");
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        temp = MapRowToProduct(reader);
                        product.Add(temp);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return product;
        }

        /// <summary>
        /// adds a product to the database
        /// </summary>
        /// <param name="product"></param>
        /// <returns>created product</returns>
        /// <exception cref="DaoException"></exception>
        public Product AddProduct(Product product)
        {
            product.ProductId = 0;
            string sql = @"INSERT INTO Product (brand, name, type, price, picture_url)
                            OUTPUT INSERTED.product_id
                            VALUES(@brand, @name, @type, @price, @picture_url);";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@brand", product.Brand);
                        cmd.Parameters.AddWithValue("@name", product.Name);
                        cmd.Parameters.AddWithValue("@type", product.Type);
                        cmd.Parameters.AddWithValue("@price", product.Price);
                        cmd.Parameters.AddWithValue("@picture_url", product.PictureUrl);
                        product.ProductId = (int)cmd.ExecuteScalar();
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return product;
        }

        /// <summary>
        /// updates a product in the database
        /// </summary>
        /// <param name="product"></param>
        /// <param name="id"></param>
        /// <returns>updated product</returns>
        /// <exception cref="DaoException"></exception>
        public UpdateProduct UpdateProduct(UpdateProduct product, int id)
        {
            string sql = @"UPDATE product SET brand = @brand, name = @name, type = @type, price = @price, picture_url = @picture_url WHERE product_id = @id;";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@brand", product.Brand);
                        cmd.Parameters.AddWithValue("@name", product.Name);
                        cmd.Parameters.AddWithValue("@type", product.Type);
                        cmd.Parameters.AddWithValue("@price", product.Price);
                        cmd.Parameters.AddWithValue("@picture_url", product.PictureUrl);
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return product;
        }

        /// <summary>
        /// deletes a product from the database
        /// </summary>
        /// <param name="id"></param>
        /// <returns>bool</returns>
        /// <exception cref="DaoException"></exception>
        public bool DeleteProduct(int id)
        {
            string sql = @"DELETE FROM product WHERE product_id = @id;";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return true;
        }
        private Product MapRowToProduct(SqlDataReader reader)
        {
            Product product = new Product();
            product.ProductId = Convert.ToInt32(reader["product_id"]);
            product.Brand = Convert.ToString(reader["brand"]);
            product.Name = Convert.ToString(reader["name"]);
            product.Type = Convert.ToString(reader["type"]);
            product.Price = Convert.ToDecimal(reader["price"]);
            product.PictureUrl = Convert.ToString(reader["picture_url"]);
            return product;
        }
    }
}
