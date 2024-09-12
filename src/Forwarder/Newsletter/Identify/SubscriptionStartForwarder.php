<?php

declare(strict_types=1);

namespace App\Forwarder\Newsletter\Identify;

use App\CDP\Analytics\Model\ModelValidator;
use App\CDP\Analytics\Model\Subscription\Identify\IdentifyModel;
use App\CDP\Analytics\Model\Subscription\Identify\SubscriptionStartMapper;
use App\CDP\Http\CdpClientInterface;
use App\DTO\Newsletter\NewsletterWebhook;
use App\Forwarder\Newsletter\ForwarderInterface;

class SubscriptionStartForwarder implements ForwarderInterface
{
    private const string SUPPORTED_EVENT = 'newsletter_subscribed';


    public function __construct(
        private CdpClientInterface $cdpClient,
        private ModelValidator $modelValidator
    ) {
    }
    public function supports(NewsletterWebhook $newsletterWebhook): bool
    {
        return $newsletterWebhook->getEvent() === self::SUPPORTED_EVENT;
    }

    public function forward(NewsletterWebhook $newsletterWebhook): void
    {
        $model = new IdentifyModel();
        (new SubscriptionStartMapper())->map($newsletterWebhook, $model);

        $this->modelValidator->validate($model);
        $this->cdpClient->identify($model);
    }
}
