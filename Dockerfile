# ----- STAGE 1: Build the application using Maven -----
# Sử dụng một image có sẵn Maven và JDK 8 để build project
FROM maven:3.8.5-openjdk-8-slim AS builder

# Đặt thư mục làm việc bên trong image
WORKDIR /app

# Copy file pom.xml trước để tận dụng Docker cache layer
# Nếu pom.xml không đổi, Docker sẽ không cần tải lại thư viện
COPY pom.xml .

# Tải tất cả các thư viện cần thiết
RUN mvn dependency:go-offline

# Copy toàn bộ source code của project
COPY src ./src

# Build ứng dụng, tạo ra file .war và bỏ qua các bài test
RUN mvn package -DskipTests


# ----- STAGE 2: Create the final production image -----
# Sử dụng một image Tomcat 9 gọn nhẹ với JRE 8
FROM tomcat:9.0-jre8-slim

# Xóa các ứng dụng web mặc định của Tomcat để dọn dẹp
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file .war đã được build từ STAGE 1 vào thư mục webapps của Tomcat
# Đặt tên file là ROOT.war để ứng dụng chạy ngay tại domain gốc (ví dụ: myapp.onrender.com)
# thay vì myapp.onrender.com/ch14-1.0-SNAPSHOT
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat chạy trên cổng 8080, chúng ta cần expose cổng này
EXPOSE 8080

# Lệnh mặc định để khởi động Tomcat khi container chạy
CMD ["catalina.sh", "run"]