package com.example.OSUMKI.services;

import com.example.OSUMKI.repositories.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ImageService {

    private final ImageRepository imageRepository;

    @Autowired
    public ImageService(ImageRepository imageRepository) {
        this.imageRepository = imageRepository;
    }
    public void deleteImageById(Long imageId) {
        imageRepository.deleteById(imageId);
    }
}
