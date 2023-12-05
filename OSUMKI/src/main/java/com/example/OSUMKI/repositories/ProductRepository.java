package com.example.OSUMKI.repositories;

import com.example.OSUMKI.models.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    @Query("SELECT DISTINCT p.brand FROM Product p")
    List<String> findAllBrands();
    @Query("SELECT DISTINCT p.title FROM Product p")
    List<String> findAllTitles();
    @Query("SELECT DISTINCT p.material FROM Product p")
    List<String> findAllMaterials();
    @Query("SELECT DISTINCT p.size FROM Product p")
    List<String> findAllSizes();
    @Query("SELECT p FROM Product p WHERE p.brand LIKE %:searchWord% OR p.title LIKE %:searchWord%")
    List<Product> findByBrandOrTitle(@Param("searchWord") String searchWord);
    List<Product> findByBrandContainingIgnoreCaseAndMaterialContainingIgnoreCaseAndSizeContainingIgnoreCaseAndPriceGreaterThanEqualAndPriceLessThanEqual(
            String brand, String material, String size, int minPrice, int maxPrice
    );
    @Query("SELECT MAX(p.price) FROM Product p")
    Integer findMaxPrice();
    @Query("SELECT MIN(p.price) FROM Product p")
    Integer findMinPrice();

}
