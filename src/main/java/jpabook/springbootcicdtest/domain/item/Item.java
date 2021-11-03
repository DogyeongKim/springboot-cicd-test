package jpabook.springbootcicdtest.domain.item;

import jpabook.springbootcicdtest.exception.NotEnoughStockException;
import lombok.Getter;
import lombok.Setter;
import jpabook.springbootcicdtest.domain.Category;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "dtype")
@Getter @Setter
public abstract class Item {

    @Id @GeneratedValue
    @Column(name = "item_id")
    private Long id;

    private String name;
    private int price;
    private int stockQuantity;

    @ManyToMany(mappedBy = "items")
    private List<Category> categories = new ArrayList<Category>();

    //==비즈니스 로직==//
    public void addStock(int quantity) {    // 파라미터로 넘어온 수만큼 재고 늘림
        this.stockQuantity += quantity;
    }

    public void removeStock(int quantity) {     // 파라미터로 넘어온 수만큼 재고 줄임
        int restStock = this.stockQuantity - quantity;
        if (restStock < 0) {
            throw new NotEnoughStockException("need more stock");
        }
        this.stockQuantity = restStock;
    }
}