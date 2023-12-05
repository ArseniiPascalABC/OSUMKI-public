package com.example.OSUMKI.controllers;

import com.example.OSUMKI.models.Image;
import com.example.OSUMKI.repositories.ImageRepository;
import com.example.OSUMKI.services.ImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;

@RestController
@RequiredArgsConstructor
public class ImageController {
    private final ImageRepository imageRepository;
    private final ImageService imageService;
    @GetMapping("/images/{id}")
    private ResponseEntity<?> getImageById(@PathVariable Long id) {
        Image image = imageRepository.findById(id).orElse(null);
        assert image != null;
        return ResponseEntity.ok()
                .header("fileName", image.getOriginalFileName())
                .contentType(MediaType.valueOf(image.getContentType()))
                .contentLength(image.getSize())
                .body(new InputStreamResource(new ByteArrayInputStream(image.getBytes())));
    }




    @DeleteMapping("/{imageId}")
    public ResponseEntity<?> deleteImageById(@PathVariable Long imageId) {
        try {
            imageService.deleteImageById(imageId);
            return new ResponseEntity<>("Фотография успешно удалена", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Ошибка при удалении фотографии: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


}
