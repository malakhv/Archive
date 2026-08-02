package tv.nemo.box.tv.ui.sections.tv.Player;


import android.animation.Animator;
import android.animation.ObjectAnimator;
import android.view.View;

/**
 * Класс содержит методы, для анимирования комопнентов UI
 *
 * */
public class AnimUtils {

    /**
     * Длительность анимации компонентов интерфейса пользователя в миллисекундах используемая
     * по умолчанию.
     * */
    public static long DEF_ANIM_DURATION = 600l;

    /**
     * Создает анимационный эффект плавного появления элемента UI из за левой границы экрана.
     *
     * @param target объект для применения анимации.
     * @param left позиция относительно левой границы экрана, в которую будет помещен
     *             объект {@code target}
     * @param duration длительность анимации в миллисекундах.
     * */
    public static void showFromLeft(View target, int left, long duration) {

        /* Создаём анимацию */
        final ObjectAnimator animator = ObjectAnimator.ofFloat(target, "х",
                target.getHeight() * -1, left);

        /* Длительность анимации */
        animator.setDuration(duration);

        /* Установка слушателя событий анимации */
        animator.addListener(new UiAnimListener(target, true));

        /* Запуск анимации */
        animator.start();

    }

    /**
     * Создает анимационный эффект плавного появления элемента UI из за левой границы экрана, по
     * которой элемент выравнивается.
     *
     * @param target объект для применения анимации.
     * */
    public static void showFromLeft(View target) {
        AnimUtils.showFromLeft(target, 0, DEF_ANIM_DURATION);
    }

    /**
     * Слушатель событий анимации для элементов UI. В зависимости от того, нужно ли показать или
     * скрыть элемент UI, делает его видимым или не видимым во время началом анимации и после её
     * окончания.
     * */
    public static class UiAnimListener implements Animator.AnimatorListener {

        /** Если равно {@code true}, нужно показать объект */
        private final boolean makeVisible;

        /** Объект для применения анимации. */
        private final View target;

        /**
         * Создаёт объект {@code UiAnimListener} с заданными параметрами, который можно
         * использовать в качестве слушателя событий анимации.
         * */
        public UiAnimListener(View target, boolean makeVisible) {
            this.makeVisible = makeVisible; this.target = target;
        }

        /** Информирует об окончании анимации. */
        @Override
        public void onAnimationEnd(Animator animation) {
            if (!makeVisible) target.setVisibility(View.GONE);
        }

        /** Информирует о начале анимации. */
        @Override
        public void onAnimationStart(Animator animation) {
            if (makeVisible) target.setVisibility(View.VISIBLE);
        }

        /** Информирует об отмене анимации. */
        @Override
        public void onAnimationCancel(Animator animation) {
            if (makeVisible) target.setVisibility(View.VISIBLE);
            else target.setVisibility(View.GONE);
        }

        /** Информирует о повторении анимации. */
        @Override
        public void onAnimationRepeat(Animator animation) {
            if (!makeVisible) target.setVisibility(View.VISIBLE);
            else target.setVisibility(View.GONE);
        }
    }

}
