package com.xml_tables_task.util;

import java.util.List;

public final class EntityPage<T> {
    private Long totalEntities;
    private List<T> entities;

    public EntityPage(long totalEntities, List<T> entities) {
        this.totalEntities = totalEntities;
        this.entities = entities;
    }

    public EntityPage() {
    }

    public Long getTotalEntities() {
        return totalEntities;
    }

    public void setTotalEntities(Long totalEntities) {
        this.totalEntities = totalEntities;
    }

    public List<T> getEntities() {
        return entities;
    }

    public void setEntities(List<T> entities) {
        this.entities = entities;
    }

    @Override
    public String toString() {
        return "EntityPage{" +
                "totalEntities=" + totalEntities +
                ", entities=" + entities +
                '}';
    }
}
