<template>
  <Head title="Главная" />
  <Header />
  <main class="main">
    <section class="hero">
      <div class="hero-inner">
        <div class="hero-text">
          <h1 class="hero-title animate-item">Вкусно и быстро</h1>
          <p class="hero-subtitle animate-item animate-delay-1">Готовим и доставляем быстро — свежие ингредиенты и горячие бургеры к вашему столу.</p>
          <div class="features animate-item animate-delay-2">
            <div class="feature-item" v-for="item in features" :key="item.text">
              <div class="feature-icon-wrap">
                <img :src="item.icon" :alt="item.text" class="feature-icon" />
              </div>
              <span class="feature-text">{{ item.text }}</span>
            </div>
          </div>
          <Link :href="route('menu')" class="btn-primary animate-item animate-delay-3">Посмотреть меню</Link>
        </div>
        <div class="hero-image-wrap animate-item animate-delay-2">
          <img src="/assets/images/MainBurger.png" alt="Бургер" class="hero-image" />
        </div>
      </div>
    </section>

    <MainCard />
    <section class="cta-section animate-item">
      <div class="cta-inner">
        <h2 class="cta-title">Есть вопросы?</h2>
        <p class="cta-desc">Напишите нам — перезвоним в течение часа</p>
        <Link :href="route('contacts')" class="btn-primary">Связаться с нами</Link>
      </div>
    </section>
    <Footer />
  </main>
</template>

<script>
import { Head, Link } from '@inertiajs/vue3';
import Header from '@/Components/Header.vue';
import Footer from '@/Components/Footer.vue';
import MainCard from '@/Components/MainCard.vue';

export default {
  components: { Head, Link, Header, Footer, MainCard },
  data() {
    return {
      features: [
        { icon: '/assets/icons/Burger.svg', text: 'Свежие ингредиенты' },
        { icon: '/assets/icons/Delivery.svg', text: 'Доставка за 30 мин' },
        { icon: '/assets/icons/Flame.svg', text: 'Вкусно' },
        { icon: '/assets/icons/Smile.svg', text: '1000+ довольных клиентов' },
      ],
    }
  },
}
</script>

<style scoped>
.main {
  min-height: 100vh;
  background: var(--color-surface);
}

.hero {
  background: var(--color-bg-hero);
  padding: 3rem 5% 4rem;
}

.hero-inner {
  max-width: 1280px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 3rem;
}

.hero-text {
  flex: 1;
  max-width: 560px;
}

.hero-title {
  font-family: var(--font-heading);
  font-size: clamp(2.5rem, 5vw, 3.5rem);
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 1rem;
  line-height: 1.1;
}

.hero-subtitle {
  font-size: 1.2rem;
  color: var(--color-text-muted);
  margin: 0 0 2rem;
  line-height: 1.5;
}

.features {
  display: flex;
  flex-wrap: wrap;
  gap: 1.5rem;
  margin-bottom: 2.5rem;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.feature-icon-wrap {
  width: 52px;
  height: 52px;
  border-radius: var(--radius);
  background: var(--color-surface);
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid var(--color-border);
}

.feature-icon {
  width: 28px;
  height: 28px;
  object-fit: contain;
}

.feature-text {
  font-size: 0.95rem;
  font-weight: 600;
  color: var(--color-text);
}

.btn-primary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 1rem 2.5rem;
  background: var(--color-primary);
  color: #fff;
  font-size: 1.15rem;
  font-weight: 700;
  font-family: var(--font-body);
  border-radius: var(--radius);
  text-decoration: none;
  transition: background 0.2s, box-shadow 0.2s, transform 0.2s;
  border: none;
  cursor: pointer;
}

.btn-primary:hover {
  background: var(--color-primary-hover);
  box-shadow: 0 8px 24px var(--color-primary-glow);
  transform: translateY(-2px);
  color: #fff;
}

.hero-image-wrap {
  flex-shrink: 0;
  max-width: 520px;
}

.hero-image {
  width: 100%;
  height: auto;
  object-fit: contain;
  filter: drop-shadow(0 24px 48px rgba(0, 0, 0, 0.4));
}

.cta-section {
  padding: 4rem 5%;
  background: var(--color-surface);
  border-top: 1px solid var(--color-border);
}

.cta-inner {
  max-width: 560px;
  margin: 0 auto;
  text-align: center;
}

.cta-title {
  font-family: var(--font-heading);
  font-size: 1.75rem;
  font-weight: 700;
  margin: 0 0 0.5rem;
}

.cta-desc {
  color: var(--color-text-muted);
  margin: 0 0 1.5rem;
}

@media (max-width: 900px) {
  .hero-inner {
    flex-direction: column;
    text-align: center;
  }

  .hero-text {
    max-width: none;
  }

  .features {
    justify-content: center;
  }

  .feature-item {
    flex-direction: column;
  }
}

@media (max-width: 768px) {
  .hero {
    padding: 2rem 4% 3rem;
  }

  .hero-inner {
    gap: 2rem;
  }

  .hero-title {
    font-size: clamp(2rem, 8vw, 2.5rem);
  }

  .hero-subtitle {
    font-size: 1.05rem;
    margin-bottom: 1.5rem;
  }

  .features {
    gap: 1rem;
    margin-bottom: 1.5rem;
  }

  .feature-icon-wrap {
    width: 44px;
    height: 44px;
  }

  .feature-icon {
    width: 24px;
    height: 24px;
  }

  .btn-primary {
    padding: 0.9rem 2rem;
    font-size: 1.05rem;
  }

  .cta-section {
    padding: 3rem 4%;
  }

  .cta-title {
    font-size: 1.5rem;
  }

  .cta-desc {
    font-size: 0.95rem;
    margin-bottom: 1.25rem;
  }
}

@media (max-width: 480px) {
  .hero {
    padding: 1.5rem 3% 2.5rem;
  }

  .hero-title {
    font-size: 1.75rem;
  }

  .hero-subtitle {
    font-size: 0.95rem;
    margin-bottom: 1.25rem;
  }

  .features {
    flex-direction: column;
    align-items: center;
    gap: 0.75rem;
    margin-bottom: 1.25rem;
  }

  .feature-item {
    flex-direction: row;
  }

  .feature-text {
    font-size: 0.9rem;
  }

  .btn-primary {
    width: 100%;
    max-width: 280px;
    padding: 0.85rem 1.5rem;
    font-size: 1rem;
  }

  .hero-image-wrap {
    max-width: 100%;
  }

  .cta-section {
    padding: 2rem 3%;
  }

  .cta-title {
    font-size: 1.35rem;
  }

  .cta-desc {
    font-size: 0.9rem;
  }
}
</style>
