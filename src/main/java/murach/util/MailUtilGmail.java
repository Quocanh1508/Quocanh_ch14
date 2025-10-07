package murach.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class MailUtilGmail {

    public static void sendMail(String to, String from,
                                String subject, String body, boolean bodyIsHTML)
            throws MessagingException {

        // 1 - Lấy một Mail Session
        Properties props = new Properties();
        props.put("mail.transport.protocol", "smtps");
        props.put("mail.smtps.host", "smtp.gmail.com");
        props.put("mail.smtps.port", 465);
        props.put("mail.smtps.auth", "true");
        props.put("mail.smtps.quitwait", "false");

        // =================================================================
        // == SỬA ĐỔI QUAN TRỌNG: ĐỌC THÔNG TIN TỪ BIẾN MÔI TRƯỜỜNG ==
        // =================================================================
        // Thay vì hard-code, chúng ta đọc từ các biến mà Render sẽ cung cấp
        final String USERNAME = System.getenv("GMAIL_USERNAME");
        final String PASSWORD = System.getenv("GMAIL_PASSWORD");
        // =================================================================

        // Kiểm tra xem biến môi trường có tồn tại không
        if (USERNAME == null || PASSWORD == null) {
            System.err.println("GMAIL_USERNAME or GMAIL_PASSWORD environment variables not set.");
            throw new MessagingException("Missing email credentials configuration.");
        }

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        // Có thể bật debug khi cần kiểm tra lỗi trên Render
        // session.setDebug(true);

        // Các bước còn lại giữ nguyên
        Message message = new MimeMessage(session);
        message.setSubject(subject);
        if (bodyIsHTML) {
            message.setContent(body, "text/html");
        } else {
            message.setText(body);
        }

        Address fromAddress = new InternetAddress(from);
        Address toAddress = new InternetAddress(to);
        message.setFrom(fromAddress);
        message.setRecipient(Message.RecipientType.TO, toAddress);

        Transport.send(message);
    }
}