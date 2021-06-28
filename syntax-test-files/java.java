import javax.inject.Singleton;
import java.util.Comparator;
import java.util.List;
import java.util.Optional

package DataStructures.HashMap.Hashing;


class HashMap {
    private int hsize;
    private LinkedList[] buckets;

    public HashMap(int hsize) {
        buckets = new LinkedList[hsize];
        for (int i = 0; i < hsize; i++) {
            buckets[i] = new LinkedList();
            // Java requires explicit initialisaton of each object
        }
        this.hsize = hsize;
    }

    public int hashing(int key) {
        int hash = key % hsize;
        if (hash < 0)
            hash += hsize;
        return hash;
    }

    public void insertHash(int key) {
        int hash = hashing(key);
        buckets[hash].insert(key);
    }


    public void deleteHash(int key) {
        int hash = hashing(key);

        buckets[hash].delete(key);
    }

    public void displayHashtable() {
        for (int i = 0; i < hsize; i++) {
            System.out.printf("Bucket %d :", i);
            buckets[i].display();
        }
    }

}



public class UnitService {
    private final UnitRepository unitRepository;
    private final StoryRepository storyRepository;


    public UnitEntity create(UnitEntity entity) {
        validate(unitEntity);
        if (unitRepository.existsByUnitIdAndVersionID(unitEntity.getUnitID(), unitEntity.getVersionId())) {
            log.error();

        }
    }

}
