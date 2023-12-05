package com.example.OSUMKI.repositories;

import com.example.OSUMKI.models.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {
    Image findOneByNameAndProductId(String name, Long productId);

    void deleteById(Long id);
}
