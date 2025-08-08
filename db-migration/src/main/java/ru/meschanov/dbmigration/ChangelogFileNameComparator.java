package ru.meschanov.dbmigration;

import java.util.Comparator;

/**
 * Компаратор для сортировки чейнджлогов перед их последовательным выполнением ликвибэйсом: сравниваются имена файлов до символа _ .
 * Класс регистрируется в include-all ченджлога (changelogs.xml).
 */
public class ChangelogFileNameComparator implements Comparator<String> {
    @Override
    public int compare(String o1, String o2) {
        String o1Prefix = getFilePrefix(o1);
        String o2Prefix = getFilePrefix(o2);

        return o1Prefix.compareTo(o2Prefix);
    }

    private String getFilePrefix(String fileName) {
        return fileName.substring(0, fileName.indexOf('_'));
    }
}
