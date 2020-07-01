    public interface ShopBackend {
        void initialize();
        Boolean hasInStock(String item);
    }