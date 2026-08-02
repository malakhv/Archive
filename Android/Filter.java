

public class Filter<T> {

    public boolean match(T object) {

    }

}

public class FilterList<T> extends Filter<T> {

    private List<Filter<T>> mFilters = null;

}

/** All */
public class FilterAnd<T> extends FilterList<T> {
    public boolean match(T object) {
        for (Filter<T> filter: mFilters) {
            if (!filter.match(T)) return false
        }
        return true;
    }
}

/** At least one */
public class FilterOr<T> extends FilterList<T> {
    public boolean match(T object) {
        for (Filter<T> filter: mFilters) {
            if (filter.match(T)) return true;
        }
    }
}