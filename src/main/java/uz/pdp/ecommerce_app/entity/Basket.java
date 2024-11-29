package uz.pdp.ecommerce_app.entity;

import lombok.Data;

import java.util.LinkedHashMap;
import java.util.Map;
@Data
public class Basket {
    Map<Product, Integer> map = new LinkedHashMap<>();
}
