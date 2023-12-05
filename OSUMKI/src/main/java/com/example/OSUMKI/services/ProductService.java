package com.example.OSUMKI.services;

import com.example.OSUMKI.models.Image;
import com.example.OSUMKI.models.Product;
import com.example.OSUMKI.models.User;
import com.example.OSUMKI.repositories.ImageRepository;
import com.example.OSUMKI.repositories.ProductRepository;
import com.example.OSUMKI.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final ImageRepository imageRepository;
    public List<String> getAllBrands() {
        return productRepository.findAllBrands();
    }
    public List<String> getAllTitles(){
        return productRepository.findAllTitles();
    }
    public List<String> getAllMaterials(){
        return productRepository.findAllMaterials();
    }
    public List<String> getAllSizes(){
        return productRepository.findAllSizes();
    }

    public User getUserByPrincipal(Principal principal){
        if (principal == null){
            return new User();
        }
        else {
            return userRepository.findByEmail(principal.getName());
        }
    }

    public List<Product> listProducts(String searchWord) {
        if ((searchWord != null) && (!searchWord.isEmpty())){
            searchWord = searchWord.trim();
            return productRepository.findByBrandOrTitle(searchWord);
        }
        else{
            return productRepository.findAll();
        }
    }

    public List<Product> findProductsByFilters(String brand, String material, String size, String minPrice, String maxPrice) {
        if ((!StringUtils.hasText(brand)) && (!StringUtils.hasText(material)) && (!StringUtils.hasText(size)) && (!StringUtils.hasText(minPrice)) && (!StringUtils.hasText(maxPrice))){
            return productRepository.findAll();
        }
        else{
            int minPriceValue = Integer.MIN_VALUE;
            if (StringUtils.hasText(minPrice)) {
                minPriceValue = Integer.parseInt(minPrice);
                minPriceValue++;
            } else {
                Integer minPriceFromDB = productRepository.findMinPrice();
                if (minPriceFromDB != null) {
                    minPriceValue = minPriceFromDB;
                }
            }
            int maxPriceValue = Integer.MAX_VALUE;
            if (StringUtils.hasText(maxPrice)) {
                maxPriceValue = Integer.parseInt(maxPrice);
                maxPriceValue--;
            } else {
                Integer maxPriceFromDB = productRepository.findMaxPrice();
                if (maxPriceFromDB != null) {
                    maxPriceValue = maxPriceFromDB;
                }
            }
            return productRepository.findByBrandContainingIgnoreCaseAndMaterialContainingIgnoreCaseAndSizeContainingIgnoreCaseAndPriceGreaterThanEqualAndPriceLessThanEqual(
                    brand, material, size, minPriceValue, maxPriceValue
            );
        }
    }
    public void saveProduct(Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        Image image1;
        Image image2;
        Image image3;
        if (file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            product.addImageToProduct(image1);
        }
        if (file2.getSize() != 0) {
            image2 = toImageEntity(file2);
            product.addImageToProduct(image2);
        }
        if (file3.getSize() != 0) {
            image3 = toImageEntity(file3);
            product.addImageToProduct(image3);
        }
        log.info("Saving new Product. Brand: {}; Material: {};", product.getBrand(), product.getMaterial());
        Product productFromDb = productRepository.save(product);
        productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
        productRepository.save(product);
    }
    public void editProduct(Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3, List<Long> deleteImageIds) throws IOException {
        Image image1;
        Image image2;
        Image image3;
        String name;
        if (deleteImageIds != null && !deleteImageIds.isEmpty()) {
            for (Long imageId : deleteImageIds) {
                imageRepository.deleteById(imageId);
            }
        }
        if (file1.getSize() != 0) {
            name = file1.getName();
            image1 = imageRepository.findOneByNameAndProductId(name, product.getId());
            image1.setContentType(file1.getContentType());
            image1.setOriginalFileName(file1.getOriginalFilename());
            image1.setName(file1.getName());
            image1.setSize(file1.getSize());
            image1.setBytes(file1.getBytes());
            if(name.equals("file1")){
                product.setPreviewImageId(image1.getId());
            }
        }
        if (file2.getSize() != 0) {
            name = file2.getName();
            image2 = imageRepository.findOneByNameAndProductId(name, product.getId());
            if (image2 == null){
                image2 = toImageEntity(file2);
                product.addImageToProduct(image2);
            }
            else {
                image2.setContentType(file2.getContentType());
                image2.setOriginalFileName(file2.getOriginalFilename());
                image2.setName(file2.getName());
                image2.setSize(file2.getSize());
                image2.setBytes(file2.getBytes());
                if (name.equals("file1")){
                    product.setPreviewImageId(image2.getId());
                }
            }
        }
        if (file3.getSize() != 0) {
            name = file3.getName();
            image3 = imageRepository.findOneByNameAndProductId(name, product.getId());
            if(image3 == null){
                image3 = toImageEntity(file3);
                product.addImageToProduct(image3);
            }
            else {
                image3.setContentType(file3.getContentType());
                image3.setOriginalFileName(file3.getOriginalFilename());
                image3.setName(name);
                image3.setSize(file3.getSize());
                image3.setBytes(file3.getBytes());
                if (name.equals("file1")){
                    product.setPreviewImageId(image3.getId());
                }
            }
        }
        log.info("Editing new Product. Brand: {}; Material: {};", product.getBrand(), product.getMaterial());
        productRepository.save(product);
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
}
