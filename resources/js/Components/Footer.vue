<template>
  <footer class="footer">
    <div class="footer-inner">
      <div class="footer-grid">
        <div class="footer-column">
          <span class="footer-label">Телефон</span>
          <a href="tel:+79243016254" class="footer-value">+7 (924) 301-62-54</a>
        </div>
        <div class="footer-column">
          <span class="footer-label">E-mail</span>
          <a href="mailto:crazyburgervdk@mail.com" class="footer-value">crazyburgervdk@mail.com</a>
        </div>
        <div class="footer-column">
          <span class="footer-label">Адрес</span>
          <span class="footer-value">г. Владивосток, ул. Шепеткова 14</span>
        </div>
        <div class="footer-column">
          <span class="footer-label">Режим работы</span>
          <span class="footer-value">пн–пт 8:00–23:00, сб–вс выходной</span>
        </div>
      </div>
      <div class="footer-socials">
        <a href="https://vk.com/club234373639" target="_blank" rel="noopener" class="social-link" aria-label="VK">
          <img src="/assets/icons/VK.svg" alt="VK" />
        </a>
        <a href="https://chat.whatsapp.com/JtPMpccmxA1EydIB6UVUQ3" target="_blank" rel="noopener" class="social-link" aria-label="WhatsApp">
          <img src="/assets/icons/WA.svg" alt="WhatsApp" />
        </a>
        <a href="https://t.me/crazyberger" target="_blank" rel="noopener" class="social-link" aria-label="Telegram">
          <img src="/assets/icons/TG.svg" alt="Telegram" />
        </a>
      </div>
      <p class="footer-copy">© Crazy Burger · Вкусно и быстро</p>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'Footer',
}
</script>

<style scoped>
.footer {
  background: var(--color-surface);
  border-top: 1px solid var(--color-border);
  padding: 3rem 0 2rem;
  margin-top: 0;
}

.footer-inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 5%;
  text-align: center;
}

.footer-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 2rem;
  margin-bottom: 2.5rem;
  text-align: center;
}

.footer-column {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.footer-label {
  font-size: 0.8rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: var(--color-text-muted);
}

.footer-value {
  color: var(--color-text);
  font-size: 1rem;
  text-decoration: none;
  transition: color 0.2s;
}

a.footer-value:hover {
  color: var(--color-primary);
}

.footer-socials {
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.social-link {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  border-radius: var(--radius);
  background: var(--color-surface-elevated);
  transition: background 0.2s, transform 0.2s;
}

.social-link:hover {
  background: var(--color-surface-hover);
  transform: translateY(-2px);
}

.social-link img {
  width: 26px;
  height: 26px;
  object-fit: contain;
}

.footer-copy {
  font-size: 0.9rem;
  color: var(--color-text-soft);
}

@media (max-width: 768px) {
  .footer {
    padding: 2rem 0 1.5rem;
  }

  .footer-inner {
    padding: 0 4%;
  }

  .footer-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
    margin-bottom: 2rem;
  }

  .footer-label {
    font-size: 0.75rem;
  }

  .footer-value {
    font-size: 0.9rem;
  }

  .social-link {
    width: 44px;
    height: 44px;
  }

  .social-link img {
    width: 22px;
    height: 22px;
  }

  .footer-copy {
    font-size: 0.8rem;
  }
}

@media (max-width: 480px) {
  .footer {
    padding: 1.5rem 0 1.25rem;
  }

  .footer-inner {
    padding: 0 3%;
  }

  .footer-grid {
    grid-template-columns: 1fr;
    gap: 1.25rem;
    margin-bottom: 1.5rem;
  }

  .footer-value {
    font-size: 0.85rem;
  }

  .footer-socials {
    gap: 1rem;
    margin-bottom: 1.5rem;
  }

  .social-link {
    width: 40px;
    height: 40px;
  }

  .social-link img {
    width: 20px;
    height: 20px;
  }
}
</style>
