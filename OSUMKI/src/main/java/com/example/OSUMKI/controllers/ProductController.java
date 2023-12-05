package com.example.OSUMKI.controllers;

import com.example.OSUMKI.models.Image;
import com.example.OSUMKI.models.Product;
import com.example.OSUMKI.models.User;
import com.example.OSUMKI.models.enums.Role;
import com.example.OSUMKI.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    @ModelAttribute("brands")
    public List<String> getAllBrands() {
        return productService.getAllBrands();
    }

    @ModelAttribute("materials")
    public List<String> getAllMaterials() {
        return productService.getAllMaterials();
    }

    @ModelAttribute("sizes")
    public List<String> getAllSizes() {
        return productService.getAllSizes();
    }

    @GetMapping("/")
    public String products(@RequestParam(name = "searchWord", required = false) String searchWord,
                           @RequestParam(name = "brand", required = false) String brand,
                           @RequestParam(name = "material", required = false) String material,
                           @RequestParam(name = "size", required = false) String size,
                           @RequestParam(name = "minPrice", required = false) String minPrice,
                           @RequestParam(name = "maxPrice", required = false) String maxPrice,
                           @RequestParam(name = "sortType", required = false) String sortType,
                           Principal principal, Model model) {
        List<Product> products;
        if (brand == null && material == null && size == null && minPrice == null && maxPrice == null) {
            products = productService.listProducts(searchWord);
        } else {
            products = productService.findProductsByFilters(brand, material, size, minPrice, maxPrice);
        }
        sort(sortType,products);
        model.addAttribute("products", products);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("searchWord", searchWord);
        model.addAttribute("brandFilter", brand);
        model.addAttribute("materialFilter", material);
        model.addAttribute("sizeFilter", size);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("sortType",sortType);
        return "products";
    }

    private void sort(@RequestParam(name = "sortType", required = false) String sortType, List<Product> products) {
        if ("expensiveFirst".equals(sortType)) {
            products.sort(Comparator.comparingInt(Product::getPrice).reversed());
        } else if ("az".equals(sortType)) {
            products.sort(Comparator.comparing(Product::getBrand));
        } else if ("za".equals(sortType)) {
            products.sort(Comparator.comparing(Product::getBrand).reversed());
        } else {
            products.sort(Comparator.comparingInt(Product::getPrice));
        }
    }



    @PostMapping("/product/create")
    public String createProduct(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3, Product product) throws IOException {
        productService.saveProduct(product, file1, file2, file3);
        return "redirect:/";
    }
    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model, Principal principal) {
        Product product = productService.getProductById(id);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("product", product);
        List<Image> sortedImages = product.getImages()
                .stream()
                .sorted(Comparator.comparing(Image::getName)) // Сортировка по имени
                .collect(Collectors.toList());
        model.addAttribute("images", sortedImages);
        return "product-info";
    }
    @PostMapping("/product/edit/{id}")
    @Transactional
    public String editProduct(@PathVariable Long id,
                              @RequestParam("file1") MultipartFile file1,
                              @RequestParam("file2") MultipartFile file2,
                              @RequestParam("file3") MultipartFile file3,
                              @RequestParam(name = "deleteImage", required = false) List<Long> deleteImageIds,
                              Product product) throws IOException {
        Product productFromDb = productService.getProductById(id);
        productFromDb.setBrand(product.getBrand());
        productFromDb.setTitle(product.getTitle());
        productFromDb.setDescription(product.getDescription());
        productFromDb.setMaterial(product.getMaterial());
        productFromDb.setSize(product.getSize());
        productFromDb.setPrice(product.getPrice());

        productService.editProduct(productFromDb, file1, file2, file3, deleteImageIds);

        return "redirect:/";
    }

    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/";
    }

}
