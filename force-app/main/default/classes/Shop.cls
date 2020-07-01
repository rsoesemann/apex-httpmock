@IsTest
@TestVisible
private class Shop {

    private ShopBackend backend;

    public Shop(ShopBackend backend) {
        this.backend = backend;

        backend.initialize();
    }

    public void buy(String item) {
        if(backend.hasInStock(item)) {
            //...
        }
    }
}