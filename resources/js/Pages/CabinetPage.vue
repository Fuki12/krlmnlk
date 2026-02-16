<template>
  <div class="cabinet-page">
    <Head title="Личный кабинет" />
    <Header />
    <main class="cabinet-main">
      <div class="cabinet-inner">
        <h1 class="page-title animate-item">Личный кабинет</h1>
        <p class="page-desc animate-item animate-delay-1">
          Добро пожаловать, <strong>{{ $page.props.auth.user.name }}</strong>
        </p>

        <div class="cabinet-cards animate-item animate-delay-2">
          <Link :href="route('profile.edit')" class="cabinet-card">
            <span class="cabinet-card-icon">👤</span>
            <h2 class="cabinet-card-title">Настройки профиля</h2>
            <p class="cabinet-card-desc">Имя, email и пароль</p>
          </Link>

          <a
            href="#"
            class="cabinet-card cabinet-card-logout"
            @click.prevent="logout"
          >
            <span class="cabinet-card-icon">🚪</span>
            <h2 class="cabinet-card-title">Выйти</h2>
            <p class="cabinet-card-desc">Завершить сеанс</p>
          </a>
        </div>

        <div class="cabinet-email animate-item animate-delay-3">
          <span class="cabinet-email-label">E-mail:</span>
          <span class="cabinet-email-value">{{ $page.props.auth.user.email }}</span>
        </div>
      </div>
    </main>
    <Footer />
  </div>
</template>

<script>
import { Head, Link, router } from '@inertiajs/vue3';
import Header from '@/Components/Header.vue';
import Footer from '@/Components/Footer.vue';

export default {
  name: 'CabinetPage',
  components: { Head, Link, Header, Footer },
  methods: {
    logout() {
      router.post(route('logout'));
    },
  },
}
</script>

<style scoped>
.cabinet-page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: var(--color-bg);
  color: var(--color-text);
}

.cabinet-main {
  flex: 1;
  padding: 2rem 5% 3rem;
}

.cabinet-inner {
  max-width: 640px;
  margin: 0 auto;
}

.page-title {
  font-family: var(--font-heading);
  font-size: clamp(2rem, 4vw, 2.5rem);
  font-weight: 700;
  text-align: center;
  margin: 0 0 0.5rem;
}

.page-desc {
  text-align: center;
  color: var(--color-text-muted);
  font-size: 1.1rem;
  margin: 0 0 2.5rem;
}

.page-desc strong {
  color: var(--color-accent);
}

.cabinet-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 1.25rem;
  margin-bottom: 2rem;
}

.cabinet-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: 1.5rem;
  text-decoration: none;
  color: inherit;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  transition: transform 0.25s, box-shadow 0.25s, border-color 0.25s;
}

.cabinet-card:hover {
  border-color: var(--color-primary);
  transform: translateY(-4px);
  box-shadow: var(--shadow-hover);
  color: var(--color-text);
}

.cabinet-card-logout {
  cursor: pointer;
}

.cabinet-card-logout:hover {
  border-color: var(--color-primary);
}

.cabinet-card-icon {
  font-size: 2rem;
}

.cabinet-card-title {
  font-family: var(--font-heading);
  font-size: 1.25rem;
  font-weight: 700;
  margin: 0;
}

.cabinet-card-desc {
  font-size: 0.95rem;
  color: var(--color-text-muted);
  margin: 0;
}

.cabinet-email {
  text-align: center;
  padding: 1rem 1.25rem;
  background: var(--color-surface);
  border-radius: var(--radius);
  border: 1px solid var(--color-border);
}

.cabinet-email-label {
  font-size: 0.85rem;
  color: var(--color-text-muted);
  margin-right: 0.5rem;
}

.cabinet-email-value {
  font-weight: 600;
}

@media (max-width: 480px) {
  .cabinet-main {
    padding: 1.5rem 3% 2rem;
  }

  .cabinet-cards {
    grid-template-columns: 1fr;
  }
}
</style>
