# 🌐 gateway

Microserviço responsável por **rotear requisições externas** para os microsserviços internos da plataforma. Atua como **API Gateway** baseado em `Spring Cloud Gateway`.

---

## 📌 Objetivo

Servir como ponto único de entrada para a plataforma, centralizando:

- Roteamento para microsserviços
- Balanceamento de carga
- Autenticação e propagação de tokens

---

## ⚙️ Stack Tecnológica

- **Linguagem:** Java
- **Framework:** Spring Boot
- **Gateway:** Spring Cloud Gateway

---

## 📁 Estrutura

- Arquitetura leve baseada em arquivos `.yml`
- Roteamento dinâmico com descoberta de serviços via `Eureka` (opcional)

---

## 🚪 Roteamento

Exemplos de rotas definidas:

```yaml
spring:
  cloud:
    gateway:
      routes:
        - id: service-product
          uri: lb://service-product
          predicates:
            - Path=/service-product/**
          filters:
            - RewritePath=/service-product/(?<remaining>.*), /${remaining}
        - id: service-user
          uri: lb://service-user
          predicates:
            - Path=/service-user/**
          filters:
            - RewritePath=/service-user/(?<remaining>.*), /${remaining}
        - id: service-file
          uri: lb://service-file/**
          predicates:
            - Path=/service-file/**