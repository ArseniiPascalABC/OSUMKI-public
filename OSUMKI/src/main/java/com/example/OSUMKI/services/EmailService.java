package com.example.OSUMKI.services;

import freemarker.template.Configuration;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.SneakyThrows;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import java.io.*;
import java.util.HashMap;
import java.util.Map;


@Service
public class EmailService {
    private final JavaMailSender mailSender;
    public EmailService(JavaMailSender mailSender, Configuration configuration) {
        this.mailSender = mailSender;
        this.configuration = configuration;
        configuration.setClassForTemplateLoading(this.getClass(), "/templates");
    }

    private final Configuration configuration;
    public boolean sendVerificationCode(String email, String verificationCode) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        helper.setFrom("senya.porfirev@bk.ru");
        helper.setTo(email);
        helper.setSubject("Код подтверждения [" + verificationCode + "]");
        Map<String, Object> model = new HashMap<>();
        model.put("verificationCode", verificationCode);
        String htmlBody = getActivationEmailContent(model);
        helper.setText(htmlBody, true);
        try {
            mailSender.send(message);
            return true;
        } catch (MailException e) {
            System.err.println(e.getMessage());
            return false;
        }
    }

    @SneakyThrows
    private String getActivationEmailContent(Map<String, Object> model) {
        StringWriter stringWriter = new StringWriter();
        configuration.getTemplate("mailMessage.ftlh")
                .process(model, stringWriter);
        return stringWriter.getBuffer()
                .toString();
    }
}
